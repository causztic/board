import React, { useContext } from "react";
import { Redirect, Route, RouteProps, Switch } from "react-router-dom";
import { Auth } from "./context/Auth";
import LoginPage from "./pages/auth/LoginPage";
import ProductsPage from "./pages/products/ProductsPage";

export const routes = [
  {
    subRoutes: [
      {path: '/', exact: true, component: LoginPage}
    ],
  },
];

export const privateRoutes = [
  {
    subRoutes: [
      {path: '/products', exact: true, component: ProductsPage}
    ],
  },
]

const PrivateRoute = ({children, location, ...rest}: RouteProps) => {
  const auth = useContext(Auth);

  return <Route {...rest} render={() => (auth.token ? children : <Redirect to="/" />)} />;
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
