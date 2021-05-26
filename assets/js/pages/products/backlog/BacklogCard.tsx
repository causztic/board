import React, { useState } from 'react';
import { Draggable } from 'react-beautiful-dnd';
import { BacklogItem } from "../types";

const component: React.FC<{ item: BacklogItem, index: number }> = ({ item, index }) => {
  const [title, setTitle] = useState<string>(item.title);
  return (<Draggable className="p-5 pl-1 bg-blue-200 mb-2" draggableId={`${item.id}`} index={index}>
    {(provided, snapshot) => (
      <div
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