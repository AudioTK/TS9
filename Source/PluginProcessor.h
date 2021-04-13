/*
  ==============================================================================

    This file was auto-generated!

    It contains the basic framework code for a JUCE plugin processor.

  ==============================================================================
*/

#pragma once

#include "JuceHeader.h"

#include <ATK/Core/InPointerFilter.h>
#include <ATK/Core/OutPointerFilter.h>
#include <ATK/Distortion/TS9OverdriveFilter.h>
#include <ATK/EQ/ButterworthFilter.h>
#include <ATK/EQ/ChamberlinFilter.h>
#include <ATK/EQ/IIRFilter.h>
#include <ATK/Tools/DecimationFilter.h>
#include <ATK/Tools/OversamplingFilter.h>
#include <ATK/Tools/VolumeFilter.h>
#include <ATK/Modelling/ModellerFilter.h>

//==============================================================================
/**
 */

class ATKTS9AudioProcessor: public AudioProcessor
{
  static constexpr int OVERSAMPLING = 8;

public:
  //==============================================================================
  ATKTS9AudioProcessor();
  ~ATKTS9AudioProcessor();

  //==============================================================================
  void prepareToPlay(double sampleRate, int samplesPerBlock) override;
  void releaseResources() override;

#ifndef JucePlugin_PreferredChannelConfigurations
  bool isBusesLayoutSupported(const BusesLayout& layouts) const override;
#endif

  void processBlock(AudioSampleBuffer&, MidiBuffer&) override;

  //==============================================================================
  AudioProcessorEditor* createEditor() override;
  bool hasEditor() const override;

  //==============================================================================
  const String getName() const override;

  bool acceptsMidi() const override;
  bool producesMidi() const override;
  double getTailLengthSeconds() const override;

  //==============================================================================
  int getNumPrograms() override;
  int getCurrentProgram() override;
  void setCurrentProgram(int index) override;
  const String getProgramName(int index) override;
  void changeProgramName(int index, const String& newName) override;

  //==============================================================================
  void getStateInformation(MemoryBlock& destData) override;
  void setStateInformation(const void* data, int sizeInBytes) override;

private:
  ATK::InPointerFilter<float> inFilter;
  ATK::OversamplingFilter<double, ATK::Oversampling6points5order_8<double>> oversamplingFilter;
  std::unique_ptr<ATK::ModellerFilter<double>> driveFilter;
  ATK::IIRFilter<ATK::ButterworthLowPassCoefficients<double>> lowpassFilter;
  ATK::DecimationFilter<double> decimationFilter;
  std::unique_ptr<ATK::ModellerFilter<double>> toneFilter;
  ATK::ChamberlinFilter<double> highpassFilter;
  ATK::VolumeFilter<double> volumeFilter;
  ATK::OutPointerFilter<float> outFilter;

  AudioProcessorValueTreeState parameters;

  float old_drive{1000};
  float old_tone{1000};
  float old_level{1000};
};
