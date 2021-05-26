import * as React from 'react';
import { BrowserRouter, Route, Switch } from 'react-router-dom';

import HomePage from './pages/HomePage';
import LoginPage from './pages/auth/LoginPage';

const Root: React.FC = () => (
  <>
    <BrowserRouter>
      <Switch>
        {/* <Route exact path="/" component={HomePage} /> */}
        <Route exact path="/" component={LoginPage} />
      </Switch>
    </BrowserRouter>
  </>
);

export default Root;