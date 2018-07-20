import {Entity, PrimaryGeneratedColumn, Column} from 'typeorm';

@Entity('damagelogs_players')
export class Player {

    @PrimaryGeneratedColumn()
    public id: number;

    @Column()
    public steamId: string;

    @Column()
    public name: string;

}
