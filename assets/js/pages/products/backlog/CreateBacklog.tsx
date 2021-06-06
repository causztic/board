import React, { BaseSyntheticEvent, useContext, useState } from 'react';
import { Input } from 'antd';
import { Auth } from '../../../context/Auth';

const component: React.FC<{ productId: string, onSubmitted: () => {} }> = ({ productId, onSubmitted }) => {
  const {api} = useContext(Auth);
  const [title, setTitle] = useState<string>();

  const createBackLogItem = (e: BaseSyntheticEvent) => {
    api.post(`/api/v1/products/${productId}/backlog_items`, { json: { title: e.target.value }}).then(() => {
      onSubmitted();
      setTitle('');
    }).catch((e) => {
      console.error(e);
    });
  }

  return <Input value={title} placeholder="Create new backlog item" onPressEnter={createBackLogItem} />;
}

export default component;