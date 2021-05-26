import React, { useContext } from "react";
import { Route, RouteProps, Switch } from "react-router-dom";
import { Auth } from "./context/Auth";
import LoginPage from "./pages/auth/LoginPage";

export const routes = [
  {
    subRoutes: [
      {path: '/login', exact: true, component: LoginPage}
    ],
  },
];

export const privateRoutes = [
  {
    subRoutes: [
      {path: '/products', exact: true, component: LoginPage}
    ],
  },
]

const PrivateRoute = ({children, location, ...rest}: RouteProps) => {
  const auth = useContext(Auth);

  return <Route {...rest} render={() => (auth.token ? children : <></>)} />;
};

export const BaseRouter: React.FunctionComponent = () => {
  return (
      <Switch>
        {routes.map((route, i) => (
          <Route
            key={i}
            exact={route.subRoutes.some((r) => r.exact)}
            path={route.subRoutes.map((r) => (r.path ? r.path.toString() : ''))}
          >
            {route.subRoutes.map((subRoute, i) => (
              <Route key={i} {...subRoute} />
            ))}
          </Route>
        ))}
        {privateRoutes.map((route, i) => (
          <PrivateRoute
            key={i}
            exact={route.subRoutes.some((r) => r.exact)}
            path={route.subRoutes.map((r) => (r.path ? r.path.toString() : ''))}
          >
            {route.subRoutes.map((subRoute, i) => (
              <Route key={i} {...subRoute} />
            ))}
          </PrivateRoute>
        ))}
      </Switch>
  );
};
