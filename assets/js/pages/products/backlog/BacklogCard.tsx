import React, { useState } from 'react';
import { BacklogItem } from "../types";

const component: React.FC<{ item: BacklogItem }> = ({ item }) => {
  const [title, setTitle] = useState<string>(item.title);

  return (<div className="p-5 pl-1 bg-blue-200 mb-2" key={item.id}>{title}</div>)
};

export default component;