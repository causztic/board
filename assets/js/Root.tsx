import * as React from 'react';
import { BrowserRouter, Route, Switch } from 'react-router-dom';

import HomePage from './pages/HomePage';
import LoginPage from './pages/auth/LoginPage';
import { AuthProvider } from './context/Auth';
import { BaseRouter } from './router';

const Root: React.FC = () => {
  return (<AuthProvider>
    <BrowserRouter>
      <BaseRouter />
    </BrowserRouter>
  </AuthProvider>)
};

export default Root;