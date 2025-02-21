import React, { useState, useEffect } from 'react';
import { canistart_task2_backend } from 'declarations/canistart_task2_backend';
import './app.css'
import { Actor, HttpAgent } from '@dfinity/agent';
import { idlFactory } from '../../declarations/canistart_task2_backend';

// Canister ID
const canisterId = 'c5kvi-uuaaa-aaaaa-qaaia-cai';

function App() {
  const [agent, setAgent] = useState(null);
  const [actor, setActor] = useState(null);
  const [isAnonymous, setIsAnonymous] = useState(null);
  const [favoriteNumber, setFavoriteNumber] = useState('');
  const [message, setMessage] = useState('');

  useEffect(() => {
    const init = async () => {
      const agent = new HttpAgent();
      await agent.fetchRootKey();
      const actor = Actor.createActor(idlFactory, { agent, canisterId });
      setAgent(agent);
      setActor(actor);
    };
    init();
  }, []);

  const checkAnonymous = async () => {
    if (actor) {
      const result = await actor.isAnonymous();
      setIsAnonymous(result);
    }
  };

  const addFavoriteNumber = async () => {
    if (actor && favoriteNumber) {
      const result = await actor.add_favourite_number_v2(Number(favoriteNumber));
      setMessage(result);
    }
  };

  const showFavoriteNumber = async () => {
    if (actor) {
      const result = await actor.show_favorite_number();
      setMessage(result ? `Your favorite number is ${result}` : 'You haven\'t registered a number yet');
    }
  };

  return (
    <div>
      <h1>Favorite Number App</h1>
      <button onClick={checkAnonymous}>Check if Anonymous</button>
      {isAnonymous !== null && <p>Is Anonymous: {isAnonymous.toString()}</p>}
      <br />
      <input 
        type="number" 
        value={favoriteNumber} 
        onChange={(e) => setFavoriteNumber(e.target.value)} 
        placeholder="Enter your favorite number"
      />
      <button onClick={addFavoriteNumber}>Add Favorite Number</button>
      <button onClick={showFavoriteNumber}>Show Favorite Number</button>
      {message && <p>{message}</p>}
    </div>
  );
}

export default App;