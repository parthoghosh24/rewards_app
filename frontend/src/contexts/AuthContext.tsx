import { createContext, ReactNode, useContext } from "react";
import Api from "../Api";

type AuthContextType = {
    login: (email: string, password: string) => Promise<void>;
    register: (email: string, password: string) => Promise<void>;
    logout: () => Promise<void>;
}

const AuthContext = createContext<AuthContextType | undefined>(undefined)

export const AuthProvider = ({children} : {children : ReactNode})=>{

    const login = async (email: string, password: string) => {
        const response = await Api.post('/login', {'user': {email, password}})
        localStorage.setItem('token', response.headers.authorization)
    }

    const register = async (email: string, password: string) => {
        const response = await Api.post('/signup', {'user': {email, password}})
        // localStorage.setItem('token', response.headers.authorization)
    }

    const logout = async () => {
        await Api.delete('/logout')
        localStorage.removeItem('token')
    }

    return (
        <AuthContext.Provider value={{login, register, logout}}>
            {children}
        </AuthContext.Provider>
    )
}

export const useAuth = () => {
    const context = useContext(AuthContext)
    if (!context) throw new Error('useAuth must be used within AuthProvider')
    return context
}