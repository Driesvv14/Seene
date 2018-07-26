package com.devhelpment.seene;

import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.TextView;

import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.ValueEventListener;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class DataActivity extends AppCompatActivity {

    private ListView listData;

    private static final String TAG = "error";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_data);


        // Define controls
        listData = (ListView) findViewById(R.id.listData);


        // Get selected device
        String device = getIntent().getStringExtra("device");


        // Create arraylists for key, data and combine

        final List<String> dataList = new ArrayList<String>();

        final List<String> keyList = new ArrayList<String>();

        final List<String> outcome = new ArrayList<String>();


        // Create arrayadapter for listview and attach

        final ArrayAdapter<String> adapter = new ArrayAdapter<String>(this, android.R.layout.simple_dropdown_item_1line, outcome);

        listData.setAdapter(adapter);


        // Firebase database reference device with child as selected device

        FirebaseDatabase database = FirebaseDatabase.getInstance();
        DatabaseReference myRef = database.getReference("devices").child(device);

        // Read from the database
        myRef.addValueEventListener(new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot dataSnapshot) {

                //Map data from datasnapshot

                Map<String, Object> map = (Map<String, Object>) dataSnapshot.getValue();

                // Place each key into list

                for (Object key : map.values()) {
                    dataList.add(key.toString());
                }


                //Place each value into list

                for (Object key : map.keySet()) {
                    keyList.add(key.toString());
                }


                // Loop over the data and place key with value into final outcome list

                for(int i = 0; i < dataList.size(); i++) {
                    String key = keyList.get(i);

                    String data = dataList.get(i);

                    outcome.add(key + ": " + data);
                }

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
