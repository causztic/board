import { Button } from 'antd';
import React from 'react';
import { Draggable } from 'react-beautiful-dnd';
import { BacklogItem } from "../types";

const component: React.FC<{ item: BacklogItem, index: number, handleDelete: (id: string) => void }> = ({ item, index, handleDelete }) => {
  return (<Draggable draggableId={`${item.id}`} index={index}>
    {(provided) => (
      <div
        className="p-5 pl-1 bg-blue-200 mb-2 flex justify-between"
        ref={provided.innerRef}
        {...provided.draggableProps}
        {...provided.dragHandleProps}
      >
        {item.title}
        <Button onClick={() => handleDelete(item.id)}>X</Button>
      </div>
    )}
  </Draggable>)
};

export default component;