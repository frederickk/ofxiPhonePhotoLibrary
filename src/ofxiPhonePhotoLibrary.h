/*
 *	ofxiPhonePhotoLibrary.h
 *	
 *	Ken Frederick
 *	ken.frederick@gmx.de
 *
 *	http://cargocollective.com/kenfrederick/
 *	http://kenfrederick.blogspot.com/
 *
 *	Copyright 2011 Ken Frederick. All rights reserved.
 *	
 */

#ifndef _IPHONE_PHOTO_LIBRARY
#define _IPHONE_PHOTO_LIBRARY


//-----------------------------------------------------------------------------
//includes
//-----------------------------------------------------------------------------
#include "ofMain.h"
#include "ofxiPhone.h"
#include "ofxiPhoneExtras.h"


enum { COLOR, GRAYSCALE };


class ofxiPhonePhotoLibrary {
protected:
	//-----------------------------------------------------------------------------
	//properties
	//-----------------------------------------------------------------------------
	ofxiPhoneImagePicker * photolibrary;
	ofImage	photoRGBA;
	ofImage photoGray;
	
	bool bLoaded;
	bool bConvert;

	//-----------------------------------------------------------------------------
	//methods
	//-----------------------------------------------------------------------------
	void flipPixels(ofxiPhoneImagePicker *imgPicked, ofImage *img);
	void grayscale(ofImage *img, int thresh = -1);

	
public:
	ofImage photo;

    
	//-----------------------------------------------------------------------------
	//constructor
	//-----------------------------------------------------------------------------
	ofxiPhonePhotoLibrary();
	
    
	//-----------------------------------------------------------------------------
	//constructor
	//-----------------------------------------------------------------------------
	~ofxiPhonePhotoLibrary();
	

	//-----------------------------------------------------------------------------
	//methods
	//-----------------------------------------------------------------------------
	void setup();
	void update();
	void draw(float x, float y, unsigned int MODE = COLOR, int thresh = -1);
	void open();


	//-----------------------------------------------------------------------------
	//gets
	//-----------------------------------------------------------------------------
	ofImage getPhoto();
	ofImage getGray(int thresh = -1);

	bool loaded();
	bool available();

};

#endif
