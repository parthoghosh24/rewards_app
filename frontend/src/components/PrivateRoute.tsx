import {ReactNode} from "react"
import {Navigate} from 'react-router-dom';

interface PrivateRouteProps {
    children: ReactNode;
  }

export const PrivateRoute = ({children} : PrivateRouteProps) => {
    const token = localStorage.getItem('token')
    return token ? children : <Navigate to ="/login" />
}