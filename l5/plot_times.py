import matplotlib.pyplot as plt
import sys
import csv

def read_csv(csv_file):
    """Read CSV file with n and time columns."""
    n_values = []
    time_values = []
    
    try:
        with open(csv_file, 'r') as f:
            reader = csv.DictReader(f)
            for row in reader:
                n_values.append(float(row['n']))
                time_values.append(float(row['time']))
    except FileNotFoundError:
        print(f"Error: File '{csv_file}' not found.")
        sys.exit(1)
    except KeyError:
        print("Error: CSV must have 'n' and 'time' columns.")
        sys.exit(1)
    
    return n_values, time_values

def plot_times(csv_file1, csv_file2=None):
    """Plot algorithm running times from CSV file(s).
    
    CSV format: n,time (with header)
    Example:
        n,time
        100,0.4083559513092041
        10000,0.16638994216918945
    """
    
    n_values1, time_values1 = read_csv(csv_file1)
    
    plt.figure(figsize=(10, 6))
    plt.plot(n_values1, time_values1, 'bo-', linewidth=2, markersize=8, label='l=10')
    
    if csv_file2 is not None:
        # Plot second dataset on the same figure
        n_values2, time_values2 = read_csv(csv_file2)
        plt.plot(n_values2, time_values2, 'ro-', linewidth=2, markersize=8, label='l=4')
    
    plt.xlabel('Problem size (n)', fontsize=12)
    plt.ylabel('Time (seconds)', fontsize=12)
    plt.title('Algorithm Running Time vs Problem Size', fontsize=13)
    plt.grid(True, alpha=0.3)
    plt.legend(fontsize=11)
    
    # Save plot
    plt.tight_layout()
    plt.savefig('algorithm_times.png', dpi=300, bbox_inches='tight')
    print("Plot saved as 'algorithm_times.png'")
    plt.show()

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python plot_times.py <csv_file1> [csv_file2]")
        print("Example: python plot_times.py times.csv")
        print("         python plot_times.py times_l1.csv times_l2.csv")
        sys.exit(1)
    
    csv_file1 = sys.argv[1]
    csv_file2 = sys.argv[2] if len(sys.argv) > 2 else None
    
    plot_times(csv_file1, csv_file2)
