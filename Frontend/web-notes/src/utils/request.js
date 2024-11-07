// src/utils/request.js
import axios from 'axios';
import { API_BASE_URL } from '@/config/setting';
import { getToken } from './token-util';

axios.defaults.withCredentials = true; // 添加此行以支持跨域携带 Cookies
const service = axios.create({
  baseURL: API_BASE_URL,
  timeout: 5000,
});

service.interceptors.request.use(
  (config) => {
    const token = getToken();
    if (token) {
      config.headers['Authorization'] = `Bearer ${token}`;
    }
    return config;
  },
  (error) => {
    return Promise.reject(error);
  }
);

service.interceptors.response.use(
  (response) => {
    return response.data;
  },
  (error) => {
    return Promise.reject(error);
  }
);

export const get = (url, params = {}) => {
  return service.get(url, { params });
};

export const post = (url, data = {}) => {
  return service.post(url, data);
};

export default service;
