import { Box, Button, Card, CardContent, Typography } from "@mui/material"
import { useRewards } from "../../../contexts/RewardsContext"
import moment from "moment"


const Redemptions = ()=>{
    const { redemptions } = useRewards()
    return(
        <Box overflow={"scroll"} height={'400px'} paddingTop={'10px'} paddingBottom={'10px'} paddingLeft={'5px'} paddingRight={'5px'} sx={{backgroundColor: 'lightgray'}}>
        {redemptions.map((redemption) =>(
            <Card key={redemption.id} variant="elevation" style={{marginTop: '10px'}}>
                <CardContent>
                    <h2>{redemption.reward.title}</h2>
                    <div style={{display: 'flex', flexDirection: 'row', width: 'inherit', justifyContent:'space-between'}}>
                        <Typography color="success">{`${redemption.reward.points} pts`}</Typography>
                        <Button variant="contained" disabled>{`Redeemed on ${moment(redemption.created_at).format('MMMM Do')}`}</Button>
                    </div>
                </CardContent>
            </Card>     
        ))}
        </Box>
     )
 }
 
 export default Redemptions