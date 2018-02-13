defmodule Memory.Game do
	
  # creats new set of cards
  def new do
    %{
       cards: createCards(),
       restrict: false, 
	   clicks: 0,
	   score: 100, 
	   matchCount: 0,
	   locked: false, 
	   previousId: 100,
	   flipState: 0,  
     }
  end

  def client_view(game) do
   
   %{
        
        cards: game[:cards], 
        restrict: game.restrict, 
		clicks: game.clicks,
		score: game.score, 
		matchCount: game.matchCount,
		locked: false, 
		previousId: game.previousId,
		flipState: game.flipState,
   } 
  end

  def createCards do
    values = ~w(A B C D E F G H A B C D E F G H)
    shuffledValues = Enum.shuffle(values)
    cardArray = [] 
    displayCards(shuffledValues,0,cardArray)
  end

  
  #shuffle letters and create a list of maps containing card attributes
  def displayCards(shuffledValues,ids,cardArray) do

      if((length shuffledValues) ==0) do

      	cardArray
        
      else

      	map = %{id: ids, key: hd(shuffledValues), matched: false, clicked: false}
        cardArray = cardArray ++ [map]
        ids = ids + 1
        displayCards(tl(shuffledValues),ids,cardArray)
        
      end 
  end

  # this event is called when the card is clicked
  def event(game,id,cardValue) do
  
  cards = game[:cards]
  nowMap = Enum.at(cards,id)
  nowClicked = nowMap[:clicked]
  restrict = game.restrict
  previousId = game.previousId
  flipState = game.flipState
  score = game.score
  clicks = game.clicks

  # a card is clicked for the first time, it enters this
  if(flipState == 0 and nowClicked==false and restrict == false) do

  	newCard = []
  	newCard = Enum.map(cards, fn(x) -> 
  
 	if x.id == id and x.clicked==false do 
  		newCard = newCard ++ %{id: x.id, key: x.key, matched: x.matched, clicked: true} 
  	else 
  		newCard = newCard ++ x 

  	end end)

  	game = %{game | previousId: id}
  	game = Map.put(game, :cards, newCard)
  	game = %{game | clicks: clicks + 1}
  	game = %{game | flipState: 1 }

  else 

  	# to check whether there is a match
  	if(nowClicked==false and restrict==false) do

  		matchCount = game.matchCount
  		previousId = game.previousId
  		prevMap = Enum.at(cards,previousId)
  		prevValue = prevMap[:key]
  		curMap = Enum.at(cards,id)
  		curValue = curMap[:key]
  		newCard = []
    	newCard = Enum.map(cards, fn(x) ->
            
    	if (x.id == id or x.id == previousId) do
    		if prevValue == curValue do
            	newCard = newCard ++ %{id: x.id, key: x.key, matched: true, clicked: true}
        
        	else 
            	newCard = newCard ++ %{id: x.id, key: x.key, matched: x.matched, clicked: true}
        
        	end

    	else

    		newCard = newCard ++ x

    	end end)

    	# if match increase the score and matchcound 
    	if prevValue == curValue do

    		game = %{game | matchCount: matchCount + 1}  		
    		score = score + 20 + (-2 * clicks)

    	else

    		score = score + (-2 * clicks);

    	end

    	game = %{game | clicks: clicks + 1}
    	game = Map.put(game, :cards, newCard)
    	game = %{game | previousId: 100}
    	game = %{game | flipState: 2 }
    	game = %{game | score: score}
    	game = %{game | restrict: true}

    else 

    	game = game

    end
 
  end

  end

  # to give delay of one second
  def wait(game) do

  	cards = game[:cards]
  	newCard = []
  	newCard = Enum.map(cards, fn(x) -> 
  
 	if x.clicked == true and x.matched==false do 
  		newCard = newCard ++ %{id: x.id, key: x.key, matched: x.matched, clicked: false} 
  	else 
  		newCard = newCard ++ x 

  	end end)

  	game = Map.put(game, :cards, newCard)
  	game = %{game | flipState: 0}
	game = %{game | restrict: false}

  end

end