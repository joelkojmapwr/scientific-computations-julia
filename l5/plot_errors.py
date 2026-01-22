import matplotlib.pyplot as plt
import sys
import csv

def read_csv(csv_file):
    """Read CSV file with n and error columns."""
    n_values = []
    error_values = []
    
    try:
        with open(csv_file, 'r') as f:
            reader = csv.DictReader(f)
            for row in reader:
                n_values.append(float(row['n']))
                error_values.append(float(row['error']))
    except FileNotFoundError:
        print(f"Error: File '{csv_file}' not found.")
        sys.exit(1)
    except KeyError:
        print("Error: CSV must have 'n' and 'error' columns.")
        sys.exit(1)
    
    return n_values, error_values

def plot_errors(csv_file1, csv_file2=None):
    """Plot algorithm errors from CSV file(s).
    
    CSV format: n,error (with header)
    Example:
        n,error
        100,1.5e-10
        10000,2.3e-9
    """
    
    n_values1, error_values1 = read_csv(csv_file1)
    
    plt.figure(figsize=(10, 6))
    plt.plot(n_values1, error_values1, 'bo-', linewidth=2, markersize=8, label='Without pivoting')
    
    if csv_file2 is not None:
        # Plot second dataset on the same figure
        n_values2, error_values2 = read_csv(csv_file2)
        plt.plot(n_values2, error_values2, 'ro-', linewidth=2, markersize=8, label='With pivoting')
    
    plt.xlabel('Problem size (n)', fontsize=12)
    plt.ylabel('Error ||x - 1||∞', fontsize=12)
    plt.title('Algorithm Error vs Problem Size', fontsize=13)
    plt.grid(True, alpha=0.3)
    plt.legend(fontsize=11)
    plt.yscale('log')  # Use log scale for error values
    
    # Save plot
    plt.tight_layout()
    plt.savefig('algorithm_errors.png', dpi=300, bbox_inches='tight')
    print("Plot saved as 'algorithm_errors.png'")
    plt.show()

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python plot_errors.py <csv_file1> [csv_file2]")
        print("Example: python plot_errors.py tests_error_without_pivoting.csv")
        print("         python plot_errors.py tests_error_without_pivoting.csv tests_error_with_pivoting.csv")
        sys.exit(1)
    
    csv_file1 = sys.argv[1]
    csv_file2 = sys.argv[2] if len(sys.argv) > 2 else None
    
    plot_errors(csv_file1, csv_file2)
