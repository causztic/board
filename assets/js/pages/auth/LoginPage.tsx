import ky from 'ky';
import React, { useState } from 'react';
import { RouteComponentProps, Link } from 'react-router-dom';

const LoginPage: React.FC<RouteComponentProps> = () => {
  const [token, setToken] = useState<string>();
  const api = (token: string) => ky.extend({
    hooks: {
      beforeRequest: [
        request => {
          request.headers.set('Authorization', `Bearer ${token}`);
        }
      ]
    }
  });

  const login = async () => {
    const response = await ky.post('/api/v1/login', { json: { email: 'limyaojie93@gmail.com', password: 'secret' } });
    if (response.ok) {
      const { token } = await response.json();
      setToken(token);
    }
  }

  const logout = async () => {
    if (token) {
      await api(token).get('/api/v1/logout');
    }
  }

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