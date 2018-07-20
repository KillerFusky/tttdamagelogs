import {Column, Entity, PrimaryGeneratedColumn} from "typeorm";

@Entity('damagelogs_logs')
export class Damagelogs {

    @PrimaryGeneratedColumn()
    id: number;

    @Column()
    public datetime: Date;

    @Column({type: "mediumtext"})
    public encodedlogs: string;

}