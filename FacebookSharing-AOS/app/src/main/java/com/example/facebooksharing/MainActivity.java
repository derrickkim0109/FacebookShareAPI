package com.example.facebooksharing;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.pm.Signature;
import android.net.Uri;
import android.os.Bundle;
import android.util.Base64;
import android.util.Log;
import android.view.View;
import android.widget.Button;

import com.facebook.appevents.AppEventsLogger;
import com.facebook.share.ShareApi;
import com.facebook.share.model.ShareContent;
import com.facebook.share.model.ShareLinkContent;
import com.facebook.share.widget.ShareButton;
import com.facebook.share.widget.ShareDialog;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class MainActivity extends AppCompatActivity {
    Button shareButton;
    Activity activity;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        shareButton = findViewById(R.id.btn_share);

        activity = this;

        AppEventsLogger.activateApp(getApplication());

        shareButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {

                ShareLinkContent shareLinkContent = new ShareLinkContent.Builder()
                        .setContentUrl(Uri.parse("https://play.google.com/store/apps/details?id=com.gogocarhome.gogocar"))
                        .build();

                ShareDialog shareDialog = new ShareDialog(activity);
                shareDialog.show(shareLinkContent, ShareDialog.Mode.FEED);
            }
        });

    }

    @Override
    protected void onResume() {
        super.onResume();
        AppEventsLogger.activateApp(getApplication());
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
        super.onActivityResult(requestCode, resultCode, data);

    }
}