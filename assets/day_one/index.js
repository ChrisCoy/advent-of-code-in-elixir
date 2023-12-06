const fs = require("fs");

const numbers = {
  ["1"]: "1",
  ["2"]: "2",
  ["3"]: "3",
  ["4"]: "4",
  ["5"]: "5",
  ["6"]: "6",
  ["7"]: "7",
  ["8"]: "8",
  ["9"]: "9",
  ["one"]: "1",
  ["two"]: "2",
  ["three"]: "3",
  ["four"]: "4",
  ["five"]: "5",
  ["six"]: "6",
  ["seven"]: "7",
  ["eight"]: "8",
  ["nine"]: "9",
};

async function main() {
  const file = await fs.promises.readFile("tests.txt");
  const lines = file.toString().split("\n");

  const algo = lines
    .map((line) => {
      const n = line.match(/one|two|three|four|five|six|seven|eight|nine|\d/g);
      if (!n) return 0;
      if (n.length === 1) return parseInt(`${numbers[n[0]]}${numbers[n[0]]}`);
      return parseInt(`${numbers[n[0]]}${numbers[n.pop()]}`);
    })
    .reduce((a, b) => a + b, 0);

  console.log(algo);

  // console.log(file.toString());
}
main();
