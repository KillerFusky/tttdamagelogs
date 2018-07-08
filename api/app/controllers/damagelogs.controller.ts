import {Router, Request, Response} from 'express';
import {Connection} from 'typeorm';
import {Damagelogs} from "../entity/Damagelogs";

class DamagelogsController {

    public router = Router();

    public constructor(private connection: Connection) {
        this.router.get('/', this.get.bind(this));
    }

    public async get(req: Request, res: Response): Promise<void> {
        const id = req.query.id;
        const oldLogs = await this.connection
            .getRepository(Damagelogs)
            .createQueryBuilder('old_log')
            .where('old_log.id = :id', {id: id})
            .getOne();
        res.json(JSON.parse(oldLogs.encodedlogs));
    }
}

export {DamagelogsController};