using CEnum

@cenum cusolverRfResetValuesFastMode_t::UInt32 begin
    CUSOLVERRF_RESET_VALUES_FAST_MODE_OFF = 0
    CUSOLVERRF_RESET_VALUES_FAST_MODE_ON = 1
end

@cenum cusolverRfMatrixFormat_t::UInt32 begin
    CUSOLVERRF_MATRIX_FORMAT_CSR = 0
    CUSOLVERRF_MATRIX_FORMAT_CSC = 1
end

@cenum cusolverRfUnitDiagonal_t::UInt32 begin
    CUSOLVERRF_UNIT_DIAGONAL_STORED_L = 0
    CUSOLVERRF_UNIT_DIAGONAL_STORED_U = 1
    CUSOLVERRF_UNIT_DIAGONAL_ASSUMED_L = 2
    CUSOLVERRF_UNIT_DIAGONAL_ASSUMED_U = 3
end

@cenum cusolverRfFactorization_t::UInt32 begin
    CUSOLVERRF_FACTORIZATION_ALG0 = 0
    CUSOLVERRF_FACTORIZATION_ALG1 = 1
    CUSOLVERRF_FACTORIZATION_ALG2 = 2
end

@cenum cusolverRfTriangularSolve_t::UInt32 begin
    CUSOLVERRF_TRIANGULAR_SOLVE_ALG1 = 1
    CUSOLVERRF_TRIANGULAR_SOLVE_ALG2 = 2
    CUSOLVERRF_TRIANGULAR_SOLVE_ALG3 = 3
end

@cenum cusolverRfNumericBoostReport_t::UInt32 begin
    CUSOLVERRF_NUMERIC_BOOST_NOT_USED = 0
    CUSOLVERRF_NUMERIC_BOOST_USED = 1
end

mutable struct cusolverRfCommon end

const cusolverRfHandle_t = Ptr{cusolverRfCommon}

@checked function cusolverRfCreate(handle)
    initialize_context()
    @ccall libcusolver.cusolverRfCreate(handle::Ptr{cusolverRfHandle_t})::cusolverStatus_t
end

@checked function cusolverRfDestroy(handle)
    initialize_context()
    @ccall libcusolver.cusolverRfDestroy(handle::cusolverRfHandle_t)::cusolverStatus_t
end

@checked function cusolverRfGetMatrixFormat(handle, format, diag)
    initialize_context()
    @ccall libcusolver.cusolverRfGetMatrixFormat(handle::cusolverRfHandle_t,
                                                 format::Ptr{cusolverRfMatrixFormat_t},
                                                 diag::Ptr{cusolverRfUnitDiagonal_t})::cusolverStatus_t
end

@checked function cusolverRfSetMatrixFormat(handle, format, diag)
    initialize_context()
    @ccall libcusolver.cusolverRfSetMatrixFormat(handle::cusolverRfHandle_t,
                                                 format::cusolverRfMatrixFormat_t,
                                                 diag::cusolverRfUnitDiagonal_t)::cusolverStatus_t
end

@checked function cusolverRfSetNumericProperties(handle, zero, boost)
    initialize_context()
    @ccall libcusolver.cusolverRfSetNumericProperties(handle::cusolverRfHandle_t,
                                                      zero::Cdouble,
                                                      boost::Cdouble)::cusolverStatus_t
end

@checked function cusolverRfGetNumericProperties(handle, zero, boost)
    initialize_context()
    @ccall libcusolver.cusolverRfGetNumericProperties(handle::cusolverRfHandle_t,
                                                      zero::Ptr{Cdouble},
                                                      boost::Ptr{Cdouble})::cusolverStatus_t
end

@checked function cusolverRfGetNumericBoostReport(handle, report)
    initialize_context()
    @ccall libcusolver.cusolverRfGetNumericBoostReport(handle::cusolverRfHandle_t,
                                                       report::Ptr{cusolverRfNumericBoostReport_t})::cusolverStatus_t
end

@checked function cusolverRfSetAlgs(handle, factAlg, solveAlg)
    initialize_context()
    @ccall libcusolver.cusolverRfSetAlgs(handle::cusolverRfHandle_t,
                                         factAlg::cusolverRfFactorization_t,
                                         solveAlg::cusolverRfTriangularSolve_t)::cusolverStatus_t
end

@checked function cusolverRfGetAlgs(handle, factAlg, solveAlg)
    initialize_context()
    @ccall libcusolver.cusolverRfGetAlgs(handle::cusolverRfHandle_t,
                                         factAlg::Ptr{cusolverRfFactorization_t},
                                         solveAlg::Ptr{cusolverRfTriangularSolve_t})::cusolverStatus_t
end

@checked function cusolverRfGetResetValuesFastMode(handle, fastMode)
    initialize_context()
    @ccall libcusolver.cusolverRfGetResetValuesFastMode(handle::cusolverRfHandle_t,
                                                        fastMode::Ptr{cusolverRfResetValuesFastMode_t})::cusolverStatus_t
end

@checked function cusolverRfSetResetValuesFastMode(handle, fastMode)
    initialize_context()
    @ccall libcusolver.cusolverRfSetResetValuesFastMode(handle::cusolverRfHandle_t,
                                                        fastMode::cusolverRfResetValuesFastMode_t)::cusolverStatus_t
end

@checked function cusolverRfSetupHost(n, nnzA, h_csrRowPtrA, h_csrColIndA, h_csrValA, nnzL,
                                      h_csrRowPtrL, h_csrColIndL, h_csrValL, nnzU,
                                      h_csrRowPtrU, h_csrColIndU, h_csrValU, h_P, h_Q,
                                      handle)
    initialize_context()
    @ccall libcusolver.cusolverRfSetupHost(n::Cint, nnzA::Cint, h_csrRowPtrA::Ptr{Cint},
                                           h_csrColIndA::Ptr{Cint}, h_csrValA::Ptr{Cdouble},
                                           nnzL::Cint, h_csrRowPtrL::Ptr{Cint},
                                           h_csrColIndL::Ptr{Cint}, h_csrValL::Ptr{Cdouble},
                                           nnzU::Cint, h_csrRowPtrU::Ptr{Cint},
                                           h_csrColIndU::Ptr{Cint}, h_csrValU::Ptr{Cdouble},
                                           h_P::Ptr{Cint}, h_Q::Ptr{Cint},
                                           handle::cusolverRfHandle_t)::cusolverStatus_t
end

@checked function cusolverRfSetupDevice(n, nnzA, csrRowPtrA, csrColIndA, csrValA, nnzL,
                                        csrRowPtrL, csrColIndL, csrValL, nnzU, csrRowPtrU,
                                        csrColIndU, csrValU, P, Q, handle)
    initialize_context()
    @ccall libcusolver.cusolverRfSetupDevice(n::Cint, nnzA::Cint, csrRowPtrA::CuPtr{Cint},
                                             csrColIndA::CuPtr{Cint},
                                             csrValA::CuPtr{Cdouble}, nnzL::Cint,
                                             csrRowPtrL::CuPtr{Cint},
                                             csrColIndL::CuPtr{Cint},
                                             csrValL::CuPtr{Cdouble}, nnzU::Cint,
                                             csrRowPtrU::CuPtr{Cint},
                                             csrColIndU::CuPtr{Cint},
                                             csrValU::CuPtr{Cdouble}, P::CuPtr{Cint},
                                             Q::CuPtr{Cint},
                                             handle::cusolverRfHandle_t)::cusolverStatus_t
end

@checked function cusolverRfResetValues(n, nnzA, csrRowPtrA, csrColIndA, csrValA, P, Q,
                                        handle)
    initialize_context()
    @ccall libcusolver.cusolverRfResetValues(n::Cint, nnzA::Cint, csrRowPtrA::CuPtr{Cint},
                                             csrColIndA::CuPtr{Cint},
                                             csrValA::CuPtr{Cdouble}, P::CuPtr{Cint},
                                             Q::CuPtr{Cint},
                                             handle::cusolverRfHandle_t)::cusolverStatus_t
end

@checked function cusolverRfAnalyze(handle)
    initialize_context()
    @ccall libcusolver.cusolverRfAnalyze(handle::cusolverRfHandle_t)::cusolverStatus_t
end

@checked function cusolverRfRefactor(handle)
    initialize_context()
    @ccall libcusolver.cusolverRfRefactor(handle::cusolverRfHandle_t)::cusolverStatus_t
end

@checked function cusolverRfAccessBundledFactorsDevice(handle, nnzM, Mp, Mi, Mx)
    initialize_context()
    @ccall libcusolver.cusolverRfAccessBundledFactorsDevice(handle::cusolverRfHandle_t,
                                                            nnzM::Ptr{Cint},
                                                            Mp::CuPtr{Ptr{Cint}},
                                                            Mi::CuPtr{Ptr{Cint}},
                                                            Mx::CuPtr{Ptr{Cdouble}})::cusolverStatus_t
end

@checked function cusolverRfExtractBundledFactorsHost(handle, h_nnzM, h_Mp, h_Mi, h_Mx)
    initialize_context()
    @ccall libcusolver.cusolverRfExtractBundledFactorsHost(handle::cusolverRfHandle_t,
                                                           h_nnzM::Ptr{Cint},
                                                           h_Mp::Ptr{Ptr{Cint}},
                                                           h_Mi::Ptr{Ptr{Cint}},
                                                           h_Mx::Ptr{Ptr{Cdouble}})::cusolverStatus_t
end

@checked function cusolverRfExtractSplitFactorsHost(handle, h_nnzL, h_csrRowPtrL,
                                                    h_csrColIndL, h_csrValL, h_nnzU,
                                                    h_csrRowPtrU, h_csrColIndU, h_csrValU)
    initialize_context()
    @ccall libcusolver.cusolverRfExtractSplitFactorsHost(handle::cusolverRfHandle_t,
                                                         h_nnzL::Ptr{Cint},
                                                         h_csrRowPtrL::Ptr{Ptr{Cint}},
                                                         h_csrColIndL::Ptr{Ptr{Cint}},
                                                         h_csrValL::Ptr{Ptr{Cdouble}},
                                                         h_nnzU::Ptr{Cint},
                                                         h_csrRowPtrU::Ptr{Ptr{Cint}},
                                                         h_csrColIndU::Ptr{Ptr{Cint}},
                                                         h_csrValU::Ptr{Ptr{Cdouble}})::cusolverStatus_t
end

@checked function cusolverRfSolve(handle, P, Q, nrhs, Temp, ldt, XF, ldxf)
    initialize_context()
    @ccall libcusolver.cusolverRfSolve(handle::cusolverRfHandle_t, P::CuPtr{Cint},
                                       Q::CuPtr{Cint}, nrhs::Cint, Temp::CuPtr{Cdouble},
                                       ldt::Cint, XF::CuPtr{Cdouble},
                                       ldxf::Cint)::cusolverStatus_t
end

@checked function cusolverRfBatchSetupHost(batchSize, n, nnzA, h_csrRowPtrA, h_csrColIndA,
                                           h_csrValA_array, nnzL, h_csrRowPtrL,
                                           h_csrColIndL, h_csrValL, nnzU, h_csrRowPtrU,
                                           h_csrColIndU, h_csrValU, h_P, h_Q, handle)
    initialize_context()
    @ccall libcusolver.cusolverRfBatchSetupHost(batchSize::Cint, n::Cint, nnzA::Cint,
                                                h_csrRowPtrA::Ptr{Cint},
                                                h_csrColIndA::Ptr{Cint},
                                                h_csrValA_array::Ptr{Ptr{Cdouble}},
                                                nnzL::Cint, h_csrRowPtrL::Ptr{Cint},
                                                h_csrColIndL::Ptr{Cint},
                                                h_csrValL::Ptr{Cdouble}, nnzU::Cint,
                                                h_csrRowPtrU::Ptr{Cint},
                                                h_csrColIndU::Ptr{Cint},
                                                h_csrValU::Ptr{Cdouble}, h_P::Ptr{Cint},
                                                h_Q::Ptr{Cint},
                                                handle::cusolverRfHandle_t)::cusolverStatus_t
end

@checked function cusolverRfBatchResetValues(batchSize, n, nnzA, csrRowPtrA, csrColIndA,
                                             csrValA_array, P, Q, handle)
    initialize_context()
    @ccall libcusolver.cusolverRfBatchResetValues(batchSize::Cint, n::Cint, nnzA::Cint,
                                                  csrRowPtrA::CuPtr{Cint},
                                                  csrColIndA::CuPtr{Cint},
                                                  csrValA_array::CuPtr{Ptr{Cdouble}},
                                                  P::CuPtr{Cint}, Q::CuPtr{Cint},
                                                  handle::cusolverRfHandle_t)::cusolverStatus_t
end

@checked function cusolverRfBatchAnalyze(handle)
    initialize_context()
    @ccall libcusolver.cusolverRfBatchAnalyze(handle::cusolverRfHandle_t)::cusolverStatus_t
end

@checked function cusolverRfBatchRefactor(handle)
    initialize_context()
    @ccall libcusolver.cusolverRfBatchRefactor(handle::cusolverRfHandle_t)::cusolverStatus_t
end

@checked function cusolverRfBatchSolve(handle, P, Q, nrhs, Temp, ldt, XF_array, ldxf)
    initialize_context()
    @ccall libcusolver.cusolverRfBatchSolve(handle::cusolverRfHandle_t, P::CuPtr{Cint},
                                            Q::CuPtr{Cint}, nrhs::Cint,
                                            Temp::CuPtr{Cdouble}, ldt::Cint,
                                            XF_array::CuPtr{Ptr{Cdouble}},
                                            ldxf::Cint)::cusolverStatus_t
end

@checked function cusolverRfBatchZeroPivot(handle, position)
    initialize_context()
    @ccall libcusolver.cusolverRfBatchZeroPivot(handle::cusolverRfHandle_t,
                                                position::CuPtr{Cint})::cusolverStatus_t
end
