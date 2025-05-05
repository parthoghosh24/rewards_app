import axios from 'axios';

const Api = axios.create({
    baseURL: 'http://localhost:3000/api/v1',
    headers: {
        'Content-type': 'application/json',
    },
})

Api.interceptors.request.use((config)=> {
    const token = localStorage.getItem('token')
    if(token && config && config.headers) {
        config.headers.Authorization = token
    }
    return config
})

export default  Api