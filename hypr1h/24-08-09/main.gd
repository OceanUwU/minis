extends Node

const SCORE_MAX := 21
const DEALER_STAND := 17

@export var card_scene: PackedScene
var bet := 1
var deck := []
var discard := []
var p_hand := []
var d_hand := []

func _ready():
    randomize()
    for i in 13:
        for j in 4:
            deck.append(i+1)
    deck.shuffle()
    deal()

func deal():
    for node in $PCards.get_children():
        node.del()
    for node in $DCards.get_children():
        node.del()
    discard.append_array(p_hand)
    p_hand.clear()
    discard.append_array(d_hand)
    d_hand.clear()
    $DScore.text = "?"
    $PScore.text = "?"
    deal_card(true, true)
    await get_tree().create_timer(0.5).timeout
    deal_card(false, false)
    $PScore.text = str(get_score(p_hand))
    await get_tree().create_timer(0.5).timeout
    deal_card(true, true)
    await get_tree().create_timer(0.5).timeout
    deal_card(false, true)
    await get_tree().create_timer(0.5).timeout
    $PScore.text = str(get_score(p_hand))
    $ActionButtons.show()
    await get_tree().create_timer(0.5).timeout
    $DScore.text = str(get_max_score(d_hand[1]))
    
func get_min_score(value: int):
    return min(value, 10)
    
func get_max_score(value: int):
    if value == 1:
        return 11
    return min(value, 10)

func get_score(hand: Array) -> int:
    var possible_scores = [0]
    for card in hand:
        for i in len(possible_scores):
            var min_s = get_min_score(card)
            var max_s = get_max_score(card)
            if (min_s != max_s):
                possible_scores.append(possible_scores[i] + max_s)
            possible_scores[i] += min_s
    possible_scores.sort()
    possible_scores.reverse()
    for i in possible_scores:
        if i <= SCORE_MAX:
            return i
    return possible_scores[len(possible_scores) - 1]

func deal_card(player: bool, flip: bool):
    var node = ($PCards if player else $DCards)
    var hand = (p_hand if player else d_hand)
    var card = get_card()
    card.target_pos = node.global_position + Vector2(45, 0) * len(hand)
    hand.append(card.value)
    node.add_child(card)
    card.global_position = $Deck.global_position
    card.scale = $Deck.scale
    await get_tree().create_timer(0.5).timeout
    if flip:
        card.flip()

func get_card() -> Node2D:
    if len(deck) == 0:
        deck.append_array(discard)
        discard.clear()
        deck.shuffle()
    var card = card_scene.instantiate()
    card.value = deck.pop_front()
    $Deck/Count.text = str(len(deck))
    return card

func _on_hit_pressed():
    $ActionButtons.hide()
    deal_card(true, true)
    await get_tree().create_timer(1.2).timeout
    $PScore.text = str(get_score(p_hand))
    if get_score(p_hand) > SCORE_MAX:
        $DCards.get_child(0).flip()
        $DScore.text = str(get_score(d_hand))
        lose()
    else:
        $ActionButtons.show()

func lose():
    $GameOver.show()

func win():
    $BetButton.show()

func _on_stand_pressed():
    $ActionButtons.hide()
    $DCards.get_child(0).flip()
    await get_tree().create_timer(0.3).timeout
    $DScore.text = str(get_score(d_hand))
    await get_tree().create_timer(0.5).timeout
    while get_score(d_hand) < DEALER_STAND:
        deal_card(false, true)
        await get_tree().create_timer(1.2).timeout
        $DScore.text = str(get_score(d_hand))
        await get_tree().create_timer(0.5).timeout
    if get_score(d_hand) > SCORE_MAX:
        win()
    elif get_score(d_hand) > get_score(p_hand):
        lose()
    else:
        win()

func _on_bet_button_pressed():
    bet *= 2
    $Bet.text = "Bet: Ð" + str(bet) + ",000,000"
    $BetButton.hide()
    deal()

func _on_button_pressed():
    bet = 1
    $Bet.text = "Bet: Ð" + str(bet) + ",000,000"
    $GameOver.hide()
    deal()
