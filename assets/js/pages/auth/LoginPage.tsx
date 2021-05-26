import ky from 'ky';
import React from 'react';
import { RouteComponentProps, Link } from 'react-router-dom';

const LoginPage: React.FC<RouteComponentProps> = () => {
  const login = async () => {
    const response = await ky.post('/api/v1/login', { json: { email: 'email', password: 'secret' } }).json();
  }

  return (
    <section className="phx-hero">
      <label>Email</label>
      <input></input>
      <label>Password</label>
      <input type="password"></input>
      <button onClick={login}>Login</button>
    </section>
  );
}

export default LoginPage;