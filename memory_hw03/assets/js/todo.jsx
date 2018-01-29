import React from 'react';
import ReactDOM from 'react-dom';

// shuffle array obtained from npm shuffle array: Src: Web
import shuffle from 'shuffle-array';
import classnames from 'classnames';



export default function run_demo(root) {
  ReactDOM.render(<MainClass />, root);
}



class MainClass extends React.Component {

  constructor(props) {

    super(props);
    this.state = {restrict:false, clicks:0,score:100, matchCount:0, cards:createCardStruct(), locked: false,previousValue:"z", previousId:100};
    this.displayCards = this.displayCards.bind(this);
    this.refresh = this.refresh.bind(this);

  }

  revealValue(cardId,cardValue){


      let currentCard = this.state.cards;

      if(currentCard[cardId].flipped === false && this.state.restrict===false){

          let clickCount = parseInt(this.state.clicks)+1;

          let curScore = parseInt(this.state.score);

          currentCard[cardId].flipped=true;

          this.setState({
            
            cards: currentCard
            
            });

          if(this.state.previousValue!="z"){


             let cardPresent = this.state.cards;
              
             if(this.state.previousValue == cardValue){

                let count = parseInt(this.state.matchCount) + 1;
                 
                 curScore = curScore + 20 + (-2 * count);


                  cardPresent[cardId].matched=true;
                  cardPresent[this.state.previousId].matched=true;

                  
                  this.setState({

                     cards: cardPresent,
                     previousValue: "z",
                     previousId:100,
                     matchCount:count,
                     score:curScore,
                     clicks:clickCount

                    });

                  if(count==8){

                    alert("you won!Score is "+curScore);

                    setTimeout(()=>{ 

                     this.setState ({ cards:createCardStruct(),matchCount:0,locked:false,
                                  previousValue: "z",previousId:100,score:100,clicks:0,
                                  restrict:false});

                    },1000);
                    
                  }
              }

              else{

                  
                var restrictTemp = this.state.restrict;

                restrictTemp = true;

                this.setState({

                  restrict:restrictTemp
                });

                curScore = curScore + (-2 * clickCount);

                setTimeout(()=>{

                restrictTemp = false;

                cardPresent[cardId].flipped=false;
                cardPresent[this.state.previousId].flipped=false;
                this.setState({

                  restrict:restrictTemp,
                  cards:cardPresent,
                  previousValue:"z",
                  previousId:100,
                  score:curScore,
                  clicks: clickCount

                });

                },1000);

              
              }

          }

          else{

              this.setState({
              previousValue:cardValue,
              previousId:cardId
            
            });

          }

      }

  }

  displayCards(cards){

    let cardList=[];
    cards.map((eachCard,offset) => {
    let makeCard= <CardComponent letter={offset} id={offset} group={eachCard} value={eachCard.letter} revealValue={this.revealValue.bind(this)} />;
    cardList.push(makeCard);
     
    });

    return cardList;

  }


  refresh(){

    this.setState ({ restrict:false, clicks:0,score:100, matchCount:0, cards:createCardStruct(), locked: false,previousValue:"z", previousId:100});

  }

  render() {

    return (
      <div>
        <div>
          <div>
            <span className="score">Score:{this.state.score}</span>
            <span className="buttonRefresh"><button className="buttonColor" onClick={this.refresh}>New Game</button></span>
          </div>
          <div class="row">
            {this.displayCards(this.state.cards)}
          </div>
        </div>

      </div>
    );
  }


}


function CardComponent(props) {
   
  let group= props.group;


  if(group.matched){

    var chosenClass = 'CardComponentMatched'

  }

  else{

    var chosenClass = 'CardComponentFlipped'
  }
 
  return (

    <div class="col-sm-3">
      <div className={chosenClass} onClick={() =>props.revealValue(props.id,props.value)}>
        {group.flipped ? group.letter : '?'}
      </div>
    </div>

  );
}


const displayValue= ['A','A','B','B','C','C','D','D','E','E','F','F','G','G','H','H'];

function createCardStruct(){

  let cardList=[];
  let i=0;
  while(i<16){

    let pair={

      id:i,
      letter:displayValue[i],
      matched: false,
      flipped:false
    };

    i=i+1;
    cardList.push(pair);

  }

  shuffle(cardList);
  return cardList;

}