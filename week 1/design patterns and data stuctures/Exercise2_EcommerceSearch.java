import java.util.Arrays;
import java.util.Comparator;

public class EcommerceSearch {

    public static Product linearSearch(Product[] products, int targetId) {
        for (Product p : products) {
            if (p.productId == targetId) {
                return p;
            }
        }
        return null;
    }

    public static Product binarySearch(Product[] products, int targetId) {
        int left = 0, right = products.length - 1;
        while (left <= right) {
            int mid = (left + right) / 2;
            if (products[mid].productId == targetId) {
                return products[mid];
            } else if (products[mid].productId < targetId) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        return null;
    }

    public static void main(String[] args) {
        Product[] products = {
            new Product(105, "Laptop", "Electronics"),
            new Product(101, "Shoes", "Footwear"),
            new Product(103, "Phone", "Electronics"),
            new Product(104, "Watch", "Accessories"),
            new Product(102, "T-shirt", "Clothing")
        };

        System.out.println(" Linear Search ");
        Product result1 = linearSearch(products, 104);
        System.out.println(result1 != null ? "Found: " + result1 : "Product not found");

        Arrays.sort(products, Comparator.comparingInt(p -> p.productId));

        System.out.println("\n Binary Search ");
        Product result2 = binarySearch(products, 104);
        System.out.println(result2 != null ? "Found: " + result2 : "Product not found");

        System.out.println("\nAnalysis:");
        System.out.println("Linear Search: O(n) — good for small, unsorted lists");
        System.out.println("Binary Search: O(log n) — best for sorted, large datasets");
    }
}
class Product {
    int productId;
    String productName;
    String category;

    public Product(int productId, String productName, String category) {
        this.productId = productId;
        this.productName = productName;
        this.category = category;
    }

    @Override
    public String toString() {
        return "[" + productId + ", " + productName + ", " + category + "]";
    }
}
