import { useEffect } from "react"
import UserPoints from "../components/Dashboard/UserPoints"
import Header from "../components/Header"
import Api from "../Api"
import { useUser } from "../contexts/UserContext"
import { Container, styled } from "@mui/material"
import Transactions from "../components/Dashboard/Transactions"
import { useRewards } from "../contexts/RewardsContext"

const Dashboard = ()=>{
    const {setPoints, setEmail} = useUser()
    const {setRewards, setRedemptions} = useRewards()
    const loadData = async () => {

        const urls = ['/user_points', '/rewards', '/redemptions']
        const requests = urls.map(url => Api.get(url, {headers: {'Authorization': localStorage.getItem('token')}}));
        const responses = await Promise.all(requests);
        const results = responses.map(response => response.data)
        if(results)
        {
            const user_points = results[0].data.points
            const user_email = results[0].data.user.email
            const rewards = results[1].data
            const redemptions = results[2].data
    
            setPoints(user_points)
            setEmail(user_email)
            setRewards(rewards)
            setRedemptions(redemptions) 
        }
    }
     
    useEffect(()=>{
        loadData()
    },[])

    const Content = styled(Container)({
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center',
        flexDirection: 'column'
      })
    
    

    return(
        <Content>
            <Header/>
            <UserPoints/>
            <Transactions/>
        </Content>
    )
}

export default Dashboard