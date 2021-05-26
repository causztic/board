import React, { useContext, useEffect, useState } from 'react';
import { RouteComponentProps } from 'react-router-dom';
import { Auth } from '../../context/Auth';
import { Product } from './types';

const component: React.FC<RouteComponentProps> = () => {
  const {api} = useContext(Auth);
  const [products, setProducts] = useState<Product[]>([]);

  useEffect(() => {
    (async () => {
      const results: { products: Product[] } = await api.get('/api/v1/products').json();
      setProducts(results.products);
    })();
  }, []);

  return (<section>
    <h1>Your Products</h1>
    <div>{products.map((product) => <div key={product.id}>{product.title}</div>)}</div>
  </section>
  )
}

export default component;
