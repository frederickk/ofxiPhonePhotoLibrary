/*
 *	ofxiPhonePhotoLibrary.mm
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


#include "ofxiPhonePhotoLibrary.h"


//-----------------------------------------------------------------------------
//constructor
//-----------------------------------------------------------------------------
ofxiPhonePhotoLibrary::ofxiPhonePhotoLibrary() {
 	photolibrary = new ofxiPhoneImagePicker();
}


//-----------------------------------------------------------------------------
//constructor
//-----------------------------------------------------------------------------
ofxiPhonePhotoLibrary::~ofxiPhonePhotoLibrary() {
}



//-----------------------------------------------------------------------------
//methods
//-----------------------------------------------------------------------------
void ofxiPhonePhotoLibrary::setup() {	
	//otherwise we will have enormous images
	photolibrary->setMaxDimension(480);
	bLoaded = false;
	bConvert = false;
	photo.loadImage("Default.png");
}



//-----------------------------------------------------------------------------
void ofxiPhonePhotoLibrary::update() {
	flipPixels(photolibrary, &photo);
}
void ofxiPhonePhotoLibrary::draw(float x, float y, unsigned int MODE, int thresh) {
    if(MODE == GRAYSCALE) {
        //photoGray.draw(x,y);
        getGray(thresh).draw(x,y);
    } else {
        photo.draw(x,y);
    }
}



//-----------------------------------------------------------------------------
void ofxiPhonePhotoLibrary::flipPixels(ofxiPhoneImagePicker *imgPicked, ofImage *img) {
	if(imgPicked->imageUpdated) {
		unsigned char *imgPixels;
		imgPixels = new unsigned char [imgPicked->width * imgPicked->height*4];
		
		for(int i=0; i<imgPicked->height; i++) {
            /* upside-down */
			//memcpy(imgPixels+(imgPicked->height-i-1)*imgPicked->width*4, imgPicked->pixels+i*imgPicked->width*4, imgPicked->width*4); 
            
            /* rightside-up */
			memcpy(imgPixels+(i)*imgPicked->width*4, imgPicked->pixels+i*imgPicked->width*4, imgPicked->width*4); 
		}
		
		img->setFromPixels(imgPixels,imgPicked->width, imgPicked->height, OF_IMAGE_COLOR_ALPHA);
		
		delete[] imgPixels;
		
		photoRGBA = photo;
		photoGray = photo;
        //photoGray = photo.setImageType(OF_IMAGE_GRAYSCALE);
		
		imgPicked->imageUpdated = false;
		bConvert = true;
        bLoaded = true;
	}
}

void ofxiPhonePhotoLibrary::grayscale(ofImage *img, int thresh) {
	if(bConvert) {
		img->setImageType(OF_IMAGE_GRAYSCALE);
		photoGray.setFromPixels(img->getPixels(), img->width,img->height, OF_IMAGE_GRAYSCALE);
		
		unsigned char *imgPixels;
		imgPixels = photoGray.getPixels();
		
		/**
		 *	thresh out, if desired
		 */
		if(thresh != -1) {
			for(int j=0; j<photoGray.width * photoGray.height; j++) {
				if(imgPixels[j] > thresh) imgPixels[j] = 255;
				else imgPixels[j] = 0;
			}
			
			photoGray.setFromPixels(imgPixels, img->width,img->height, OF_IMAGE_GRAYSCALE);
			photoGray.update();
		}	
		
		bConvert = false;
	}
}


//-----------------------------------------------------------------------------
void ofxiPhonePhotoLibrary::open() { 
	photolibrary->openLibrary();
}



//-----------------------------------------------------------------------------
//gets
//-----------------------------------------------------------------------------
ofImage ofxiPhonePhotoLibrary::getPhoto() {
	return photo;
}

ofImage ofxiPhonePhotoLibrary::getGray(int thresh) {
	grayscale(&photo, thresh);
	return photoGray;
}


//-----------------------------------------------------------------------------
bool ofxiPhonePhotoLibrary::loaded() {
	return bLoaded;
}
bool ofxiPhonePhotoLibrary::available() {
	return photolibrary->photoLibraryIsAvailable;
}


