import ky from 'ky';
import React, { useState } from 'react';
import { RouteComponentProps, Link } from 'react-router-dom';

const LoginPage: React.FC<RouteComponentProps> = () => {
  return (
    <section className="phx-hero">
      <label>Email</label>
      <input></input>
      <label>Password</label>
      <input type="password"></input>
      <button onClick={login}>Login</button>
      <button onClick={logout}>Logout</button>
    </section>
  );
}

export default LoginPage;