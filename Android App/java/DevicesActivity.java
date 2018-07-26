package com.devhelpment.seene;


import android.app.Activity;
import android.content.Intent;
import android.support.annotation.NonNull;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.ValueEventListener;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class DevicesActivity extends AppCompatActivity {


    private ListView listDevices;

    private static final String TAG = "error";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_devices);

        // Define controls
        listDevices = (ListView) findViewById(R.id.listDevices);

        // Create arraylists for device

        final List<String> devicesList = new ArrayList<String>();

        // Create arrayadapter for listview and attach

        final ArrayAdapter<String> adapter = new ArrayAdapter<String>(this, android.R.layout.simple_dropdown_item_1line, devicesList);

        listDevices.setAdapter(adapter);


        // Create OnItemClickListener for item in list

        listDevices.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position,
                                    long id) {

                String item = ((TextView) view).getText().toString();

                // Pass device to next activity

                Intent intent = new Intent(getBaseContext(), DataActivity.class);
                intent.putExtra("device", item);
                startActivity(intent);
            }
        });

        // Firebase database reference device

        FirebaseDatabase database = FirebaseDatabase.getInstance();
        DatabaseReference myRef = database.getReference("devices");

        // Read from the database
        myRef.addValueEventListener(new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot dataSnapshot) {

                //Map data from datasnapshot

                Map<String, Object> map = (Map<String, Object>) dataSnapshot.getValue();

                // Place each device into list

                for (String key : map.keySet()) {
                    devicesList.add(key);
                }

                Log.d(TAG, "Value is: " + devicesList);


                //Notify adapter about changes

                adapter.notifyDataSetChanged();

            }

            @Override
            public void onCancelled(DatabaseError error) {
                Log.w(TAG, "Failed to read value.", error.toException());
            }
        });


    }

}
