import { createContext, ReactNode, useContext, useState } from "react";

type UserContextType = {
    email: string,
    points: number,
    setEmail: (email: string) => void,
    setPoints: (points: number) => void,
}

const UserContext = createContext<UserContextType | undefined>(undefined)

export const UserProvider = ({children} : {children : ReactNode})=>{
    const [email, setEmail] = useState("")

    const [points, setPoints] = useState(0)

    return (
        <UserContext.Provider value={{email, points, setEmail, setPoints}}>
            {children}
        </UserContext.Provider>
    )
}

export const useUser = () => {
    const context = useContext(UserContext)
    if (!context) throw new Error('useUser must be used within UserProvider')
    return context
}