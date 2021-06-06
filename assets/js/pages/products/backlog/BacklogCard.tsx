import React from 'react';
import { Draggable } from 'react-beautiful-dnd';
import { BacklogItem } from "../types";

const component: React.FC<{ item: BacklogItem, index: number }> = ({ item, index }) => {
  return (<Draggable draggableId={`${item.id}`} index={index}>
    {(provided) => (
      <div
        className="p-5 pl-1 bg-blue-200 mb-2"
        ref={provided.innerRef}
        {...provided.draggableProps}
        {...provided.dragHandleProps}
      >
        {item.title}
      </div>
    )}
  </Draggable>)
};

export default component;