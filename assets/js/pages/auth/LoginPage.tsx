import React, { useContext } from 'react';
import { RouteComponentProps, withRouter } from 'react-router-dom';
import { Auth } from '../../context/Auth';

const LoginPage: React.FC<RouteComponentProps> = ({ history }) => {
  const { login, logout } = useContext(Auth);
  const loginWithParams = async () => {
    const loggedIn = await login('limyaojie93@gmail.com', 'secret');
    if (loggedIn) {
      history.push('/products');
    }
  }

  return (
    <section className="phx-hero">
      <label>Email</label>
      <input></input>
      <label>Password</label>
      <input type="password"></input>
      <button onClick={loginWithParams}>Login</button>
      <button onClick={logout}>Logout</button>
    </section>
  );
}

export default withRouter(LoginPage);