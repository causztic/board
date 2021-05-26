import React, { useContext, useEffect, useState } from 'react';
import { RouteComponentProps, useParams } from 'react-router-dom';
import { Auth } from '../../context/Auth';
import { BacklogItem } from './types';
import {Channel, Socket} from "phoenix";

const component: React.FC<RouteComponentProps> = () => {
  const [socket, setSocket] = useState<Socket>();
  const [channel, setChannel] = useState<Channel>();
  const {api, token} = useContext(Auth);
  const { id: productId } = useParams<{ id: string }>();
  const [backlogItems, setBackLogItems] = useState<BacklogItem[]>([]);
  const broadcastPing = (id: string) => {
    channel.push('ping', { body: id });
  }

  useEffect(() => {
    setSocket(new Socket("/socket", {params: { token }}));

    (async () => {
      const results: { backlog_items: BacklogItem[] } = await api.get(`/api/v1/products/${productId}/backlog_items`).json();
      setBackLogItems(results.backlog_items);
    })();
  }, []);

  useEffect(() => {
    if (socket !== undefined) {
      socket.connect();
      setChannel(socket.channel(`board:products:${productId}`, {}));
    }
  }, [socket])

  useEffect(() => {
    if (channel !== undefined) {
      channel.join();
    }
  }, [channel])

  return (<section>
    <h1>Product Backlog</h1>
    <div>{backlogItems.map((item) => <div key={item.id} onClick={() => broadcastPing(item.id)}>{item.title}</div>)}</div>
  </section>
  )
}

export default component;