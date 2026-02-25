import sys


def find_citi_data(filename):
    """Reads a file line-by-line, searches for 'citi', and prints the second field."""
    result = []
    try:
        with open(filename, "r") as file:
            for line_number, line in enumerate(file, 1):
                if "citi" in line.lower():
                    fields = line.strip().split(",")

                    if len(fields) > 1:
                        print(fields[1].strip())
                        result.append(fields[1])

                    else:
                        print(
                            f"Warning: Line {line_number} contains 'citi' but doesn't have a second field: {line.strip()}",
                            file=sys.stderr,
                        )
        return result

    except FileNotFoundError:
        # Standard error for file-related issues
        print(f"Error: The file '{filename}' was not found.", file=sys.stderr)
        sys.exit(1)  # Exit with an error code


# Standard way to run the main function when the script is executed
if __name__ == "__main__":
    # Check if a filename was provided as a command-line argument
    if len(sys.argv) > 1:
        # sys.argv[1] is the first argument after the script name
        result = find_citi_data(sys.argv[1])
    else:
        print("Usage: python citi_finder.py <filename>", file=sys.stderr)
        sys.exit(1)

    print(result)
