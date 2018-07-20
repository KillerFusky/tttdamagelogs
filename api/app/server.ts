import * as express from 'express';
import {DamagelogsController} from "./controllers/damagelogs.controller";
import {Connection, createConnection} from 'typeorm';
import {AbstractEvent} from "../dmglogs_common/events/abstractEvent";

createConnection().then((connection: Connection) => {

    new AbstractEvent();

    const app  = express();
    app.use('/damagelogs', new DamagelogsController(connection).router);

    app.use((req: express.Request, res: express.Response, next: express.NextFunction) => {
        res.setHeader('Content-Type', 'application/json');
        next();
    });

    const port = process.env.PORT || 3000;
    app.listen(port, () => {
        console.log(`Listening at http://localhost:${port}/`);
    });

}).catch(error => console.log(error));


