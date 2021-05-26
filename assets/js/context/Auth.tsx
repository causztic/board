import ky from 'ky';
import React, { useState } from 'react';

declare type AuthContext = {
  token: string | null,
  api: typeof ky,
  login: (email: string, password: string) => Promise<boolean>,
  logout: () => void,
}

const auth: AuthContext = {
  token: null,
  api: ky,
  login: (email: string, password: string) => Promise.resolve(true),
  logout: () => {}
}

export const Auth = React.createContext(auth);

export const AuthProvider = ({ children }: any) => {
  const api = ky.extend({
    hooks: {
      beforeRequest: [
        request => {
          request.headers.set('Authorization', `Bearer ${token}`);
        }
      ]
    }
  });

  const login = async (email: string, password: string) => {
    const response = await ky.post('/api/v1/login', { json: { email, password } });
    if (response.ok) {
      const { token } = await response.json();
      setToken(token);
      localStorage.setItem('board-token', token);
      return true;
    }

    return false;
  }

  const logout = async () => {
    await api.get('/api/v1/logout');
  }

  // TODO: handle when cookies are disabled
  const [token, setToken] = useState<string | null>(localStorage.getItem('board-token'));

  const context = {
    token,
    api,
    login,
    logout,
  }

  return <Auth.Provider value={context}>{children}</Auth.Provider>
}