import React, { BaseSyntheticEvent, useContext, useState } from 'react';
import { Button, Form, Input } from 'antd';
import { Auth } from '../../../context/Auth';

const component: React.FC<{ productId: string, onSubmitted: () => {} }> = ({ productId, onSubmitted }) => {
  const {api} = useContext(Auth);
  const [form] = Form.useForm();

  const createBackLogItem = (values: Record<string, string>) => {
    api.post(`/api/v1/products/${productId}/backlog_items`, { json: values }).then(() => {
      onSubmitted();
      form.resetFields();
    }).catch((e) => {
      console.error(e);
    });
  }

  return <Form form={form} onFinish={createBackLogItem}>
        <Form.Item name="title" required>
          <Input placeholder="Create new backlog item" />
        </Form.Item>
        <Form.Item>
          <Button type="primary" htmlType="submit">
            Submit
          </Button>
        </Form.Item>
    </Form>
}

export default component;