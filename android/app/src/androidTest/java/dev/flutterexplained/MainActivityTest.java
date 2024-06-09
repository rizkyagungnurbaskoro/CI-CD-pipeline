package dev.flutterexplained;

import androidx.test.ext.junit.rules.ActivityScenarioRule;
import androidx.test.ext.junit.runners.AndroidJUnit4;
import org.junit.Rule;
import org.junit.Test;
import org.junit.runner.RunWith;
import static org.junit.Assert.*;

import com.example.flutter_application_1.MainActivity;

@RunWith(AndroidJUnit4.class)
public class MainActivityTest {

    @Rule
    public ActivityScenarioRule<MainActivity> rule = new ActivityScenarioRule<>(MainActivity.class);

    @Test
    public void testExample() {
        // Add your test code here
        // For example, you might check if a view is displayed
        rule.getScenario().onActivity(activity -> {
            assertNotNull(activity.findViewById(R.id.some_view));
        });
    }
}
