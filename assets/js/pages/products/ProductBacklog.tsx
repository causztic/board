import React, { useCallback, useContext, useEffect, useState } from 'react';
import { RouteComponentProps, useParams } from 'react-router-dom';
import { DragDropContext, Droppable } from 'react-beautiful-dnd';
import { Auth } from '../../context/Auth';
import { BacklogItem } from './types';
import {Channel, Socket} from "phoenix";
import BacklogCard from './backlog/BacklogCard';
import CreateBacklog from './backlog/CreateBacklog';

function reorder<T>(list: Array<T>, startIndex: number, endIndex: number): Array<T> {
  const result = Array.from(list);
  const [removed] = result.splice(startIndex, 1);
  result.splice(endIndex, 0, removed);

  return result;
};

const component: React.FC<RouteComponentProps> = () => {
  const [socket, setSocket] = useState<Socket>();
  const [channel, setChannel] = useState<Channel>();
  const {api, token} = useContext(Auth);
  const { id: productId } = useParams<{ id: string }>();
  const [backlogItems, setBackLogItems] = useState<BacklogItem[]>([]);
  // const broadcastPing = (id: string) => {
  //   channel.push('ping', { body: id });
  // }

  const getBacklogItems = async () => {
    const results: { backlog_items: BacklogItem[] } = await api.get(`/api/v1/products/${productId}/backlog_items`).json();
    setBackLogItems(results.backlog_items);
  };

  useEffect(() => {
    setSocket(new Socket("/socket", {params: { token }}));
    getBacklogItems();
  }, []);

  useEffect(() => {
    if (socket !== undefined) {
      socket.connect();
      setChannel(socket.channel(`board:products:${productId}`, {}));
    }

    return () => {
      socket?.disconnect();
    }
  }, [socket])

  useEffect(() => {
    channel?.join();

    return () => {
      channel?.leave();
    }
  }, [channel])

  const onDragEnd = useCallback((result, provided) => {
    if (!result.destination) {
      return;
    }

    const items = reorder(
      backlogItems,
      result.source.index,
      result.destination.index
    );

    setBackLogItems(items);
  }, [backlogItems]);

  return (<section>
    <h1>Product Backlog</h1>
    {/* TODO: use sockets to update */}
    <CreateBacklog productId={productId} onSubmitted={getBacklogItems} />
    <DragDropContext onDragEnd={onDragEnd}>
      <Droppable droppableId="droppable">
        {(provided) => (
            <div
              {...provided.droppableProps}
              ref={provided.innerRef}
            >
              {backlogItems.map((item, index) => <BacklogCard key={item.id} item={item} index={index} />)}
              {provided.placeholder}
            </div>
          )}
      </Droppable>
    </DragDropContext>
  </section>
  )
}

export default component;