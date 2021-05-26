import * as React from 'react';
import { BrowserRouter, Route, Switch } from 'react-router-dom';

import { AuthProvider } from './context/Auth';
import { BaseRouter } from './router';

const Root: React.FC = () => {
  return (
    <div className="container mx-auto">
      <AuthProvider>
        <BrowserRouter>
          <BaseRouter />
        </BrowserRouter>
      </AuthProvider>
    </div>
  )
};

export default Root;