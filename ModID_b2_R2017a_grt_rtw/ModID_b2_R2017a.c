/*
 * ModID_b2_R2017a.c
 *
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * Code generation for model "ModID_b2_R2017a".
 *
 * Model version              : 1.5
 * Simulink Coder version : 8.12 (R2017a) 16-Feb-2017
 * C source code generated on : Fri May 10 11:40:36 2019
 *
 * Target selection: grt.tlc
 * Note: GRT includes extra infrastructure and instrumentation for prototyping
 * Embedded hardware selection: Intel->x86-64 (Windows64)
 * Code generation objective: Execution efficiency
 * Validation result: Passed (11), Warning (1), Error (0)
 */

#include "ModID_b2_R2017a.h"
#include "ModID_b2_R2017a_private.h"

/* Block signals (auto storage) */
B_ModID_b2_R2017a_T ModID_b2_R2017a_B;

/* Continuous states */
X_ModID_b2_R2017a_T ModID_b2_R2017a_X;

/* External outputs (root outports fed by signals with auto storage) */
ExtY_ModID_b2_R2017a_T ModID_b2_R2017a_Y;

/* Real-time model */
RT_MODEL_ModID_b2_R2017a_T ModID_b2_R2017a_M_;
RT_MODEL_ModID_b2_R2017a_T *const ModID_b2_R2017a_M = &ModID_b2_R2017a_M_;

/*
 * This function updates continuous states using the ODE3 fixed-step
 * solver algorithm
 */
static void rt_ertODEUpdateContinuousStates(RTWSolverInfo *si )
{
  /* Solver Matrices */
  static const real_T rt_ODE3_A[3] = {
    1.0/2.0, 3.0/4.0, 1.0
  };

  static const real_T rt_ODE3_B[3][3] = {
    { 1.0/2.0, 0.0, 0.0 },

    { 0.0, 3.0/4.0, 0.0 },

    { 2.0/9.0, 1.0/3.0, 4.0/9.0 }
  };

  time_T t = rtsiGetT(si);
  time_T tnew = rtsiGetSolverStopTime(si);
  time_T h = rtsiGetStepSize(si);
  real_T *x = rtsiGetContStates(si);
  ODE3_IntgData *id = (ODE3_IntgData *)rtsiGetSolverData(si);
  real_T *y = id->y;
  real_T *f0 = id->f[0];
  real_T *f1 = id->f[1];
  real_T *f2 = id->f[2];
  real_T hB[3];
  int_T i;
  int_T nXc = 2;
  rtsiSetSimTimeStep(si,MINOR_TIME_STEP);

  /* Save the state values at time t in y, we'll use x as ynew. */
  (void) memcpy(y, x,
                (uint_T)nXc*sizeof(real_T));

  /* Assumes that rtsiSetT and ModelOutputs are up-to-date */
  /* f0 = f(t,y) */
  rtsiSetdX(si, f0);
  ModID_b2_R2017a_derivatives();

  /* f(:,2) = feval(odefile, t + hA(1), y + f*hB(:,1), args(:)(*)); */
  hB[0] = h * rt_ODE3_B[0][0];
  for (i = 0; i < nXc; i++) {
    x[i] = y[i] + (f0[i]*hB[0]);
  }

  rtsiSetT(si, t + h*rt_ODE3_A[0]);
  rtsiSetdX(si, f1);
  ModID_b2_R2017a_step();
  ModID_b2_R2017a_derivatives();

  /* f(:,3) = feval(odefile, t + hA(2), y + f*hB(:,2), args(:)(*)); */
  for (i = 0; i <= 1; i++) {
    hB[i] = h * rt_ODE3_B[1][i];
  }

  for (i = 0; i < nXc; i++) {
    x[i] = y[i] + (f0[i]*hB[0] + f1[i]*hB[1]);
  }

  rtsiSetT(si, t + h*rt_ODE3_A[1]);
  rtsiSetdX(si, f2);
  ModID_b2_R2017a_step();
  ModID_b2_R2017a_derivatives();

  /* tnew = t + hA(3);
     ynew = y + f*hB(:,3); */
  for (i = 0; i <= 2; i++) {
    hB[i] = h * rt_ODE3_B[2][i];
  }

  for (i = 0; i < nXc; i++) {
    x[i] = y[i] + (f0[i]*hB[0] + f1[i]*hB[1] + f2[i]*hB[2]);
  }

  rtsiSetT(si, tnew);
  rtsiSetSimTimeStep(si,MAJOR_TIME_STEP);
}

/* Model step function */
void ModID_b2_R2017a_step(void)
{
  if (rtmIsMajorTimeStep(ModID_b2_R2017a_M)) {
    /* set solver stop time */
    if (!(ModID_b2_R2017a_M->Timing.clockTick0+1)) {
      rtsiSetSolverStopTime(&ModID_b2_R2017a_M->solverInfo,
                            ((ModID_b2_R2017a_M->Timing.clockTickH0 + 1) *
        ModID_b2_R2017a_M->Timing.stepSize0 * 4294967296.0));
    } else {
      rtsiSetSolverStopTime(&ModID_b2_R2017a_M->solverInfo,
                            ((ModID_b2_R2017a_M->Timing.clockTick0 + 1) *
        ModID_b2_R2017a_M->Timing.stepSize0 +
        ModID_b2_R2017a_M->Timing.clockTickH0 *
        ModID_b2_R2017a_M->Timing.stepSize0 * 4294967296.0));
    }
  }                                    /* end MajorTimeStep */

  /* Update absolute time of base rate at minor time step */
  if (rtmIsMinorTimeStep(ModID_b2_R2017a_M)) {
    ModID_b2_R2017a_M->Timing.t[0] = rtsiGetT(&ModID_b2_R2017a_M->solverInfo);
  }

  /* Outport: '<Root>/Theta' incorporates:
   *  Integrator: '<Root>/Integrator1'
   */
  ModID_b2_R2017a_Y.Theta = ModID_b2_R2017a_X.Integrator1_CSTATE;

  /* Integrator: '<Root>/Integrator' */
  ModID_b2_R2017a_B.theta_dot = ModID_b2_R2017a_X.Integrator_CSTATE;

  /* Gain: '<Root>/Gain' incorporates:
   *  Gain: '<Root>/Gain1'
   *  Gain: '<Root>/Gain2'
   *  Integrator: '<Root>/Integrator1'
   *  Sum: '<Root>/Add'
   *  Trigonometry: '<Root>/Sin'
   */
  ModID_b2_R2017a_B.Gain = ((0.0 - 0.026487 * sin
    (ModID_b2_R2017a_X.Integrator1_CSTATE)) - 0.0002 *
    ModID_b2_R2017a_B.theta_dot) * 9090.90909090909;
  if (rtmIsMajorTimeStep(ModID_b2_R2017a_M)) {
    rt_ertODEUpdateContinuousStates(&ModID_b2_R2017a_M->solverInfo);

    /* Update absolute time for base rate */
    /* The "clockTick0" counts the number of times the code of this task has
     * been executed. The absolute time is the multiplication of "clockTick0"
     * and "Timing.stepSize0". Size of "clockTick0" ensures timer will not
     * overflow during the application lifespan selected.
     * Timer of this task consists of two 32 bit unsigned integers.
     * The two integers represent the low bits Timing.clockTick0 and the high bits
     * Timing.clockTickH0. When the low bit overflows to 0, the high bits increment.
     */
    if (!(++ModID_b2_R2017a_M->Timing.clockTick0)) {
      ++ModID_b2_R2017a_M->Timing.clockTickH0;
    }

    ModID_b2_R2017a_M->Timing.t[0] = rtsiGetSolverStopTime
      (&ModID_b2_R2017a_M->solverInfo);

    {
      /* Update absolute timer for sample time: [0.2s, 0.0s] */
      /* The "clockTick1" counts the number of times the code of this task has
       * been executed. The resolution of this integer timer is 0.2, which is the step size
       * of the task. Size of "clockTick1" ensures timer will not overflow during the
       * application lifespan selected.
       * Timer of this task consists of two 32 bit unsigned integers.
       * The two integers represent the low bits Timing.clockTick1 and the high bits
       * Timing.clockTickH1. When the low bit overflows to 0, the high bits increment.
       */
      ModID_b2_R2017a_M->Timing.clockTick1++;
      if (!ModID_b2_R2017a_M->Timing.clockTick1) {
        ModID_b2_R2017a_M->Timing.clockTickH1++;
      }
    }
  }                                    /* end MajorTimeStep */
}

/* Derivatives for root system: '<Root>' */
void ModID_b2_R2017a_derivatives(void)
{
  XDot_ModID_b2_R2017a_T *_rtXdot;
  _rtXdot = ((XDot_ModID_b2_R2017a_T *) ModID_b2_R2017a_M->derivs);

  /* Derivatives for Integrator: '<Root>/Integrator1' */
  _rtXdot->Integrator1_CSTATE = ModID_b2_R2017a_B.theta_dot;

  /* Derivatives for Integrator: '<Root>/Integrator' */
  _rtXdot->Integrator_CSTATE = ModID_b2_R2017a_B.Gain;
}

/* Model initialize function */
void ModID_b2_R2017a_initialize(void)
{
  /* Registration code */

  /* initialize real-time model */
  (void) memset((void *)ModID_b2_R2017a_M, 0,
                sizeof(RT_MODEL_ModID_b2_R2017a_T));

  {
    /* Setup solver object */
    rtsiSetSimTimeStepPtr(&ModID_b2_R2017a_M->solverInfo,
                          &ModID_b2_R2017a_M->Timing.simTimeStep);
    rtsiSetTPtr(&ModID_b2_R2017a_M->solverInfo, &rtmGetTPtr(ModID_b2_R2017a_M));
    rtsiSetStepSizePtr(&ModID_b2_R2017a_M->solverInfo,
                       &ModID_b2_R2017a_M->Timing.stepSize0);
    rtsiSetdXPtr(&ModID_b2_R2017a_M->solverInfo, &ModID_b2_R2017a_M->derivs);
    rtsiSetContStatesPtr(&ModID_b2_R2017a_M->solverInfo, (real_T **)
                         &ModID_b2_R2017a_M->contStates);
    rtsiSetNumContStatesPtr(&ModID_b2_R2017a_M->solverInfo,
      &ModID_b2_R2017a_M->Sizes.numContStates);
    rtsiSetNumPeriodicContStatesPtr(&ModID_b2_R2017a_M->solverInfo,
      &ModID_b2_R2017a_M->Sizes.numPeriodicContStates);
    rtsiSetPeriodicContStateIndicesPtr(&ModID_b2_R2017a_M->solverInfo,
      &ModID_b2_R2017a_M->periodicContStateIndices);
    rtsiSetPeriodicContStateRangesPtr(&ModID_b2_R2017a_M->solverInfo,
      &ModID_b2_R2017a_M->periodicContStateRanges);
    rtsiSetErrorStatusPtr(&ModID_b2_R2017a_M->solverInfo, (&rtmGetErrorStatus
      (ModID_b2_R2017a_M)));
    rtsiSetRTModelPtr(&ModID_b2_R2017a_M->solverInfo, ModID_b2_R2017a_M);
  }

  rtsiSetSimTimeStep(&ModID_b2_R2017a_M->solverInfo, MAJOR_TIME_STEP);
  ModID_b2_R2017a_M->intgData.y = ModID_b2_R2017a_M->odeY;
  ModID_b2_R2017a_M->intgData.f[0] = ModID_b2_R2017a_M->odeF[0];
  ModID_b2_R2017a_M->intgData.f[1] = ModID_b2_R2017a_M->odeF[1];
  ModID_b2_R2017a_M->intgData.f[2] = ModID_b2_R2017a_M->odeF[2];
  ModID_b2_R2017a_M->contStates = ((X_ModID_b2_R2017a_T *) &ModID_b2_R2017a_X);
  rtsiSetSolverData(&ModID_b2_R2017a_M->solverInfo, (void *)
                    &ModID_b2_R2017a_M->intgData);
  rtsiSetSolverName(&ModID_b2_R2017a_M->solverInfo,"ode3");
  rtmSetTPtr(ModID_b2_R2017a_M, &ModID_b2_R2017a_M->Timing.tArray[0]);
  ModID_b2_R2017a_M->Timing.stepSize0 = 0.2;

  /* block I/O */
  (void) memset(((void *) &ModID_b2_R2017a_B), 0,
                sizeof(B_ModID_b2_R2017a_T));

  /* states (continuous) */
  {
    (void) memset((void *)&ModID_b2_R2017a_X, 0,
                  sizeof(X_ModID_b2_R2017a_T));
  }

  /* external outputs */
  ModID_b2_R2017a_Y.Theta = 0.0;

  /* InitializeConditions for Integrator: '<Root>/Integrator1' */
  ModID_b2_R2017a_X.Integrator1_CSTATE = -3.1415926535897931;

  /* InitializeConditions for Integrator: '<Root>/Integrator' */
  ModID_b2_R2017a_X.Integrator_CSTATE = 0.0;
}

/* Model terminate function */
void ModID_b2_R2017a_terminate(void)
{
  /* (no terminate code required) */
}
