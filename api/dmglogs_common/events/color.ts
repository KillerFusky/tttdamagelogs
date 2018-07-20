export class Color {

    public constructor(public r: number = 0,
                       public g: number = 0,
                       public b: number = 0,
                       public a: number = 255) {

    }

    public static BLACK = new Color(0, 0, 0);

}