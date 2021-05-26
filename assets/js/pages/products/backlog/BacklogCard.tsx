import React from 'react';
import { BacklogItem } from "../types";

const component: React.FC<{ item: BacklogItem }> = ({ item }) => {
  return (<div key={item.id}>{item.title}</div>)
};

export default component;