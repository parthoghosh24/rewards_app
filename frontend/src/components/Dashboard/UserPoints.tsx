import { useUser } from "../../contexts/UserContext"
import Card from '@mui/material/Card';
import CardContent from '@mui/material/CardContent';

const UserPoints = ()=>{
    const { points } = useUser()
   return(
    <Card style={{width: '640px'}}>
        <CardContent>
            <p>Your Points</p>
            <h1>{`${points} pts`}</h1>
        </CardContent>
    </Card>
    )
}

export default UserPoints