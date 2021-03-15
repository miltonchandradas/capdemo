using {db} from '../db/schema';

service TechService {

    entity UXTeam as select from db.UXTeam;
    
}