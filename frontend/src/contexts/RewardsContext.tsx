import { createContext, ReactNode, useContext, useState } from "react";

type RewardsContextType = {
    rewards: Array<Object>,
    redemptions: Array<Object>,
    setRewards: (rewards: Array<Object>) => void,
    setRedemptions: (redemptions: Array<Object>) => void,
}

const RewardsContext = createContext<RewardsContextType | undefined>(undefined)

export const RewardsProvider = ({children} : {children : ReactNode})=>{

    const [rewards, setRewards] = useState<Array<Object>>([])

    const [redemptions, setRedemptions] = useState<Array<Object>>([])

    return (
        <RewardsContext.Provider value={{rewards, redemptions, setRewards, setRedemptions}}>
            {children}
        </RewardsContext.Provider>
    )
}

export const useRewards = () => {
    const context = useContext(RewardsContext)
    if (!context) throw new Error('useRewards must be used within RewardsProvider')
    return context
}