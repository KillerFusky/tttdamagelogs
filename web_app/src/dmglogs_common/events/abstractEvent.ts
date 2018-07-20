import {Color} from "./color";

export abstract class AbstractEvent {

    protected constructor(public eventName: string) {
    }

    abstract toString(): string;

    public getColor(): Color {
        return Color.BLACK;
    }

}