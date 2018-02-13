import React from 'react';
import ReactDOM from 'react-dom';

// shuffle array obtained from npm shuffle array: Src: Web
import shuffle from 'shuffle-array';
import classnames from 'classnames';


export default function game_init(root,channel) {
  ReactDOM.render(<MainClass channel={channel} />, root);
}



class MainClass extends React.Component {

  constructor(props) {

    super(props);
    this.channel = props.channel;
    this.state = {restrict:false, clicks:0,score:100, matchCount:0, cards:[], locked: false, flipState: 0, previousId:100};
    this.displayCards = this.displayCards.bind(this);
    this.refresh = this.refresh.bind(this);

    this.channel.join()
        .receive("ok", this.gotView.bind(this))
        .receive("error",resp => {console.log("unable to join",resp)});
   
  }

  gotView(view){

    let current_state = this; 

    this.setState(view.game);

    if(view.game.matchCount==8){

      alert("you won!Score is "+view.game.score);
      this.channel.push("refresh",{name:"z"})
      .receive("ok", this.gotView.bind(this));
    }
    if (view.game.flipState == 2){
    
      setTimeout(function(){current_state.channel.push("wait", {name: "z"}).receive("ok", current_state.gotView.bind(current_state))},1000);
    }
  }

  revealValue(cardId,cardValue){

    if (this.state.restrict == false){

      this.channel.push("event",{id:cardId,body:cardValue})
        .receive("ok", this.gotView.bind(this));
    }

  }

  displayCards(cards){

    let cardList=[];
    cards.map((eachCard,offset) => {
    let makeCard= <CardComponent id={eachCard.id} group={eachCard} value={eachCard.key} revealValue={this.revealValue.bind(this)} 
                   matched = {eachCard.matched} flipped = {eachCard.clicked} />;
    cardList.push(makeCard);
     
    });

    return cardList;

  }


  refresh(){

    this.channel.push("refresh",{name:"z"})
      .receive("ok", this.gotView.bind(this));
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


  if(props.matched){

    var chosenClass = 'CardComponentMatched'

  }

  else{

    var chosenClass = 'CardComponentFlipped'
  }
 
  return (

    <div class="col-sm-3">
      <div className={chosenClass} onClick={() =>props.revealValue(props.id,props.value)}>
        {props.flipped ? props.value : '?'}
      </div>
    </div>

  );
}

